# frozen_string_literal: true

module FitbitClient
  module Resources
    module Activity
      # The Get Lifetime Stats endpoint retrieves the user's activity statistics
      # in the format requested using units in the unit system which corresponds
      # to the Accept-Language header provided.
      #
      # Activity statistics includes Lifetime and Best achievement values
      # from the My Achievements tile on the website dashboard.
      #
      # Response contains both statistics from the tracker device and
      # total numbers including tracker data and manual activity log entries
      # as seen on the Fitbit website dashboard.
      def lifetime_stats(options = {})
        get_json(path_user_version('/activities', options))
      end

      # The Get Daily Activity Summary endpoint retrieves a summary and list
      # of a user's activities and activity log entries for a given day in the
      # format requested using units in the unit system which corresponds to
      # the Accept-Language header provided.
      def daily_activity_summary(date, options = {})
        get_json(path_user_version("/activities/date/#{iso_date(date)}", options))
      end

      # The Get Activity Time Series endpoint returns time series data in
      # the specified range for a given resource in the format requested
      # using units in the unit system that corresponds to
      # the Accept-Language header provided.
      def activity_time_series(resource, date, period_or_end_date, options = {})
        period = period_or_date_param(period_or_end_date)
        path = "/activities/#{resource}/date/#{iso_date(date)}/#{period}"
        get_json(path_user_version(path, options))
      end

      # Get a tree of all valid Fitbit public activities from the activities
      # catalog as well as private custom activities the user created in the
      # format requested.
      #
      # If the activity has levels, also get a list of activity level details.
      def browse_activity_types(options = {})
        skip_user_options!(options)
        get_json(path_user_version('/activities', options))
      end

      # Returns the details of a specific activity in the Fitbit activities
      # database in the format requested. If activity has levels, also returns
      # a list of activity level details.
      #
      #   activity_id : The activity id
      def activity_type(activity_id, options = {})
        skip_user_options!(options)
        get_json(path_user_version("/activities/#{activity_id}", options))
      end

      # The Get Recent Activity Types endpoint retrieves a list of a user's
      # recent activities types logged with some details of the last activity
      # log of that type using units in the unit system which corresponds to
      # the Accept-Language header provided.
      #
      # The record retrieved can be used to log the activity via the
      # Log Activity endpoint with the same or adjusted values for distance
      # and duration.
      def recent_activity_types(options = {})
        get_json(path_user_version('/activities/recent', options))
      end

      # The Get Favorite Activities endpoint returns a list of a user's
      # favorite activities.
      def favorite_activities
        get_json(path_user_version('/activities/favorite'))
      end

      # The Get Activity Logs List endpoint retrieves a list of a user's
      # activity log entries before or after a given day with offset and
      # limit using units in the unit system which corresponds
      # to the Accept-Language header provided.
      def activity_logs_list(before_date, after_date, options = {})
        if before_date
          params = { 'beforeDate' => before_date, 'sort' => 'desc', 'limit' => '20', 'offset' => '0' }
        elsif after_date
          params = { 'afterDate' => after_date, 'sort' => 'asc', 'limit' => '20', 'offset' => '0' }
        end
        get_json(path_user_version('/activities/list', options), params)
      end

      # The Add Favorite Activity endpoint adds the activity with the given ID
      # to user's list of favorite activities.
      #
      #   activity_id : The ID of the activity to add to user's favorites.
      def add_favorite_activity(activity_id)
        successful_post?(post(path_user_version("/activities/favorite/#{activity_id}")))
      end

      # The Delete Favorite Activity removes the activity with the given ID
      # from a user's list of favorite activities.
      #
      #   activity_id : The ID of the activity to be removed.
      def delete_favorite_activity(activity_id)
        successful_delete?(delete(path_user_version("/activities/favorite/#{activity_id}")))
      end
    end
  end
end
