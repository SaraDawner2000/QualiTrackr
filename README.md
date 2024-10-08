# QUALITRACKR
QualityTrackr is a document and process management system designed for creating, tracking and assembling new part quality documentation records for customers.

## About
Creating and managing quality control documentation for the Production Part Approval Process (PPAP) is a significant challenge for manufacturers. This industry standard ensures that engineering design and product specifications are met by suppliers. This process is essential for gaining approval for manufactured parts, reducing delays, and ensuring consistency. PPAP documentation is crucial in industries like automotive and is increasingly required due to global sustainability regulations.

Quickly, accurately, and consistently producing PPAP documentation gives suppliers a competitive edge and access to new markets. Delays in this process can disrupt customer production, lower satisfaction, and delay payments. The complexity of PPAP records, which include data from various production stages, makes tracking and assembling them a difficult and time-consuming task.

QualiTrackr consolidates all components of a PPAP record in one place and tracks the status of all ongoing Quality Control projects. This system will streamline the process, eliminate delays, and enhance customer satisfaction.

### Build With

[![Rails 7.1.3.4][Rails-shield]][Rails-url]

[![Bootstrap 5.3.3][Bootstrap-shield]][Bootstrap-url]

## Getting Started
To setup:
1. fork repo
2. clone locally
3. run `bundle install`

There are 5 seeded accounts for looking around the website:
1. ndworknstudy@gmail.com -- role: Quality Manager, admin: yes
2. alice@example.com -- role: Quality Manager, admin: no
3. bob@example.com -- role: Quality Admin, admin: no
5. carol@example.com -- role: QC tech, admin: no
6. dave@example.com -- role: Production manager, admin: no

The password for all of them is "password"

### Prerequisites
1. ruby 3.3.4
2. PostgreSQL 14.12
3. Google maps API key in the .env file for landing page


## Usage
* Database initialization:

run `rake dev:reset` to setup the database locally with custom sample data.

## Entity Relationship Diagram
![Diagram](/app/assets/images/erd.png)







<!-- MARKDIWN KINKS & IMAGES -->
[Rails-shield]: https://img.shields.io/badge/Ruby_on_rails-D30001?style=for-the-badge&logo=rubyonrails&logoColor=white
[Rails-url]: https://rubyonrails.org/

[Bootstrap-shield]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
