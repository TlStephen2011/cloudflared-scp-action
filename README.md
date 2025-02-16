# Cloudflared Headless - Copy File To Remote Server

A GitHub Action that runs a Docker container, which lets you copy a file into a server behind a Cloudflare Tunnel

## Inputs

The following inputs can be used as `step.with` keys:

| Name                   | Type   | Required | Description                                                             |
| ---------------------- | ------ | -------- | ----------------------------------------------------------------------- |
| `host`                 | String | `true`   | Tunnel address of the server you are connecting to                      |
| `port`                 | int    | `true`   | SSH port                                                                |
| `username`             | String | `true`   | SSH username                                                            |
| `private_key_filename` | String | `true`   | Name of the private key file (used only in the action runner execution) |
| `private_key_value`    | String | `true`   | The actual SSH private key to authenticate to your server               |
| `service_token_id`     | String | `true`   | The Cloudflare Zero Trust Service Token ID                              |
| `service_token_secret` | String | `true`   | The Cloudflare Zero Trust Service Token Secret                          |
| `source`               | String | `true`   | The Source File to be copied                                            |
| `target`               | String | `true`   | The Target File to be copied to                                         |


## Usage

Here is an example deploy.yaml file for the action:

```yaml
name: Run command on remote server
on:
  pull_request:
    types:
      - closed
jobs:
  transfer:
    runs-on: ubuntu-latest
    steps:
      - name: Transfer file to server
        uses: TlStephen2011/cloudflared-scp-action@v0.0.4
        with:
          host: ${{ secrets.SSH_HOST }}
          username: ${{ secrets.SSH_USERNAME }}
          private_key_filename: ${{ secrets.SSH_PRIVATE_KEY_FILENAME }}
          private_key_value: ${{ secrets.SSH_PRIVATE_KEY_VALUE }}
          port: ${{ secrets.SSH_PORT }}
          source: ./app-artifacts.tar.gz
          target: ~/app
          service_token_id: ${{ secrets.SERVICE_TOKEN_ID }}
          service_token_secret: ${{ secrets.SERVICE_TOKEN_SECRET }}
```

## Additional information

- This action requires a service token id and a service token secret because it provides a headless way to copy over a file via scp to the remote machine

### How To

- In your cloudfare zero trust dashboard:
    - Navigate to Access -> Service Auth - then create a new service token
    - You must then create a policy - Access -> Policies
        - Fill in the policy name and set the 'Action' as 'Service Auth'
    - You must then create an application using that policy
        - Access -> Applications -> Click on 'Policies' tab and 'Select existing policies' -> choose previously created policy
- Congratulations, you must now use that service token id and service token secret in the action