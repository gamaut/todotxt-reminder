# todotxt-reminder

This shell script processes a `todo.txt` file to generate daily itemized lists
of tasks grouped by context. It focuses on tasks due today, tomorrow, or
overdue and can be used to email a summary every morning. It ignores tasks
marked as done (`x `).

## Usage

1. Ensure the script is executable.

    ```sh
    chmod +x todotxt-reminder.sh
    ```

2. Execute the script to generate the filtered task lists.

    ```sh
    ./todotxt-reminder.sh
    ```

3. Add the script to a cron job for automated daily execution and send the output to your email.

    ```sh
    # Add the following line to run the script daily at 7 AM and email the output:
    0 7 * * * /path/to/todotxt-reminder.sh | mail -s "Daily Task List" your-email@example.com
    ```

## Example

Given a `todo.txt` file with the following content:

```
(A) Discuss project focus with James due:2024-07-01 @James
(B) Finalize shipping for Canary Islands due:2024-06-28 +CustomerX @James
(B) Ensure automated export running due:2024-06-27 +CustomerZ @John
(C) Confirm DE availability due:2024-06-28 +CustomerZ @John
(C) Review summer recruitment plan due:2024-06-29 @Saskia
```

The script will output (if run on June 27):

```
@James
(B) Finalize shipping for Canary Islands due:2024-06-28 +CustomerX

@John
(B) Ensure automated export running due:2024-06-27 +CustomerZ
(C) Confirm DE availability due:2024-06-28 +CustomerZ
```

## Requirements

- `awk`, `grep`, `date`, and other standard Unix utilities
