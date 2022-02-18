# docker-jest-evaluator-action
Docker Jest evaluator action for Tryber projects

This action evaluate Tryber projects with [Jest](https://jestjs.io/) library.

Based on https://github.com/betrybe/jest-evaluator-action/tree/v9

**Require the `Setup NodeJS` action to be executed prior to the action**
## Inputs

- `challenges_folder`
    
  **Required**
  
  **Default**: `app`
    
  (path) Folder that contains the docker-compose.yml file

- `puppeteer_test`

  Optional

  **Default**: `undefined`

  (true | undefined) Install chrome´s puppeteer requirements

- `run_compose`

  Optional

  **Default**: `undefined`

  (true | undefined) Run docker-compose in `challenges_folder` after `npm install`

- `wait_for`

  Optional

  **Default**: `undefined`

  (url | undefined) **Depends on `run_compose`**. Application URL in docker-compose to be expected

- `pr_author_username`

  **Required**

  (string) Pull Request author username

## Outputs

- `result`

  Jest unit tests JSON results in base64 format.

## Usage example

The difference between this action and the original one is that it opens up so that you can access the docker on the host system (VM).

It is therefore possible to execute a docker command to create a container based on the student's project.

## How to get result output (v3)
```yml
- name: Fetch Docker Jest evaluator
  uses: actions/checkout@v2
  with:
    repository: betrybe/docker-jest-evaluator-action
    ref: v1.1
    token: ${{ secrets.GIT_HUB_PAT }}
    path: .github/actions/docker-jest-evaluator

- name: Setup NodeJS
  uses: actions/setup-node@v1.4.6
  with:
    node-version: '16'

- name: Run Docker Jest evaluation
  id: jest_eval
  uses: ./.github/actions/docker-jest-evaluator
  with:
    puppeteer_test: true
    run_compose: true
    wait_for: 'http://localhost:3000'
    pr_author_username: ${{ github.event.inputs.pr_author_username }}}

- name: Next step
  uses: another-github-action
  with:
    param: ${{ steps.evaluator.outputs.result }}
```

## Project contraints

The project that want to use this action should implement unit tests grouping them using `describe` statements.
Each `describe` statement will be mapped to a requirement.

Example:

```javascript
describe('requirement #1' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});

describe('requirement #2' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});

describe('requirement #3' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});
```

Project repository must create a file called `requirements.json` inside `.trybe` folder.

This file should have the following structure:

```json
{
  "requirements": [{
    "description": "requirement #1",
    "bonus": false
  }, {
    "description": "requirement #2",
    "bonus": true
  }, {
    "description": "requirement #3",
    "bonus": false
  }]
}
```

where the `"requirement #1"`, `"requirement #2"` and `"requirement #3"` are the requirements and describes names.

## Learn about GitHub Actions

- https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-a-docker-container-action
