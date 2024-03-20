# Terraform project

![A hero starting their journey looking at a tower](./media/images/journey.png "A hero starting their journey looking at a tower")

Thus far on our Northcoders journey into Cloud Engineering we had encountered various pieces of the Terraform journey in separation. This project required me to bring together all the knowledge I had acquired (plus some more from the terraform docs!) to put together a more complex infrastructure.

## Goals

The target for this project was to create a hosted network of microservices that mocks a smart home network with; a central status service, a lights service, a heating service, and an authorisation service.

I completed the project with enough time to go through and improve upon the original 'basic' apps, to deliver additional functionality - in particular, I linked the auth service to an actual database, and mocked up a hashing function to act as a layer of security to prevent user passwords being stored in plain text in the AWS dynamodb.
