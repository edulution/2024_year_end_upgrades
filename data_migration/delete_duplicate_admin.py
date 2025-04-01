import kolibri  # noqa F401
import django
import sys

django.setup()

from kolibri.core.auth.models import FacilityUser, Role
from kolibri.core.auth.constants.role_kinds import COACH


def delete_recent_user_with_duplicate_username(username):
    try:
        # Get all users with the specified username
        users = FacilityUser.objects.filter(username=username)

        if users.count() <= 1:
            print(f"No duplicate users found for username '{username}'.")
            return

        # Find the most recently created user
        most_recent_user = users.order_by("date_joined").first()

        # Delete the most recently created user
        most_recent_user.delete()
        print(f"Deleted the most recently created user with username '{username}'.")
    except Exception as e:
        print(f"An error occurred: {e}")


def grant_coach_permissions_to_matching_users():
    try:
        # Filter users whose username contains 'coach' (case-insensitive)
        matching_users = FacilityUser.objects.filter(username__icontains="coach")

        if not matching_users.exists():
            print("No users found with 'coach' in their username.")
            return

        for user in matching_users:
            # Check if the user already has a coach role
            existing_role = Role.objects.filter(user=user, kind=COACH).first()

            if existing_role:
                print(f"User '{user.username}' already has coach permissions.")
            else:
                # Assign the coach role to the user
                Role.objects.create(user=user, kind=COACH, collection=user.facility)
                print(f"Granted coach permissions to user '{user.username}'.")

        print("Operation completed.")
    except Exception as e:
        print(f"An error occurred: {e}")


# Grant coach permissions
grant_coach_permissions_to_matching_users()


# Delete duplicate admin users
delete_recent_user_with_duplicate_username("admin")
