# defi-letters
The deficiency letter is a letter we send out to our clients who have a surplus of overpaid funds from a auctions transaction.

The SQL Querey collects the desired data from a list that the user provides to it

The following code defilettersii.py takes that data, does the arithmatic of the total sale and sale fees minus remaining principle, interest, and account outstanding fees.

task_batcher.py is the centralize location to run the defilettersii.py in a while True loop.

The results are word documents with clients name, account information, and explanation of surplus.

For privacy reasons I have only provided a screenshot of the arithmatic portion of the results defi_letter_git.pdf
