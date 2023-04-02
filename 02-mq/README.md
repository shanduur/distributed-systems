# Requirements

- Docker

## Tasks

1. Create application that will perform the following tasks:
    - Send a message to a Message Queue (MQ) with the following information:
        - The current time.
        - The name of the host.
        - The name of the application.

2. Create a second application that will perform the following tasks:
    - Receive messages from the MQ.
    - Add the following information to the message:
        - The current time.
        - The name of the host.
        - The name of the application.
    - Send the message back to the MQ.

3. Create a third application that will:
    - Receive messages from the MQ.
    - Add message to a database/file.
