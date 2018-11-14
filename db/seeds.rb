# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

CATEGORIES    = ['Landesa Materials', 'Articles', 'Legal Materials', 'Citations', 'News & Commentary', 'Legal Research Resources', 'Research Articles', 'Practice Guides', 'Citation']
JURISDICTIONS = ['International', 'Provincial', 'National', 'Regional', 'Local', 'Multinational', 'State', 'None']
LANGUAGES     = ['English', 'French', 'Chinese', 'Spanish', 'Portuguese', 'Dutch', 'Arabic', 'Russian', 'Romanian', 'Greek', 'Italian', 'German', 'Danish', 'Lithuanian', 'Czech', 'Albanian', 'Slovene', 'Ukrainian', 'Amharic', 'Gaelic', 'Bengali', 'Tigrigna', 'Acholi']
TOPICS        = ['Revenue/Taxation', 'Land Reform', 'Inheritance', 'Constitution', 'Equal Rights', 'Customary Practices', 'Children', 'Forests', 'Bride Price or Dowry', 'Polygamy', 'Widows', 'Co-ownership', 'Dispute Resolution', 'Marriage & Divorce', 'Land & Property', 'Governance', 'Civil Code', 'Country Profile', 'Girls', 'Practice Guide', 'Research Resources', 'Employment', 'Need Help Locating Full-Text', 'Labor', 'Environment', 'Climate Change', 'HIV/AIDS', 'Gender Based Violence/Domestic Violence', 'Conflict/Post-Conflict', 'Gender Equality', 'Health', 'Hiv/Aids', 'Poverty', 'Land & Property', 'Restricted Access', 'VPP Readings', 'Co Ownership', 'Conflict/Post Conflict', 'Mining', 'Communal Land', 'Pastoralism', 'Research Consortium']
COUNTRIES     = ["India", "China", "Uganda", "Burundi", "Rwanda", "Tanzania", "Kenya", "Ghana", "Mozambique", "Zambia", "South Africa", "Zimbabwe", "Democratic Republic of the Congo", "Cameroon", "Sierra Leone", "Senegal", "Ethiopia", "Malawi", "Botswana", "Namibia", "Bangladesh", "Cambodia", "Nepal", "Sri Lanka", "Kyrgyz Republic", "Peru", "Indonesia", "Liberia", "Guatemala", "Nigeria", "Philippines", "South Sudan", "Pakistan", "Angola", "Lesotho", "Eritrea", "Swaziland", "Argentina", "Bolivia", "Brazil", "Chile", "Ecuador", "Paraguay", "Suriname", "Uruguay", "Venezuela", "Guyana", "Colombia", "Belize", "Costa Rica", "El Salvador", "Honduras", "Mexico", "Nicaragua", "Panama", "Bermuda", "Canada", "Greenland", "Falkland Islands", "Puerto Rico", "United States Virgin Islands", "Dominican Republic", "Haiti", "Jamaica", "Trinidad and Tobago", "Antigua and Barbuda", "Anguilla", "Bahamas", "Barbados", "Aruba", "Curacao", "Sint Maarten", "British Virgin Islands", "Cayman Islands", "Cuba", "Dominica", "Grenada", "Montserrat", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Bonaire", "French Guiana", "Saint Barthelemy", "Saint Martin", "Martinique", "Guadeloupe", "Saint Pierre et Miquelon", "Benin", "Afghanistan", "Burkina Faso", "Vietnam", "Japan", "Taiwan", "Solomon Islands", "Bougainville", "Armenia", "Azerbaijan", "Bahrain", "Bhutan", "Brunei", "Cyprus", "North Korea", "Georgia", "Hong Kong", "Iran", "Iraq", "Israel", "Jordan", "Kazakhstan", "Kuwait", "Laos", "Lebanon", "Macao", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Oman", "Qatar", "South Korea", "Saudi Arabia", "Singapore", "Syrian Arab Republic", "Thailand", "Timor-Leste", "Tajikistan", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Yemen", "Algeria", "Chad", "Cape Verde", "Central African Republic", "Comoros", "Congo", "Cote d'Ivoire", "Djibouti", "Egypt", "Equatorial Guinea", "Gabon", "Guinea", "Guinea-Bissau", "Libya", "Madagascar", "Mali", "Mauritania", "Mauritius", "Morocco", "Niger", "Saint Helena, Ascension & Tristan da Cunha", "Sao Tome and Principe", "Seychelles", "Somalia", "Sudan", "The Gambia", "Togo", "Tunisia", "Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia & Herzegovina", "Bulgaria", "Croatia", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Latvia", "Lithuania", "Luxembourg", "Macedonia", "Malta", "Monaco", "Netherlands", "Poland", "Russian Federation", "Serbia", "Slovenia", "Sweden", "Kosovo", "Australia", "New Zealand", "Papua New Guinea", "Ukraine", "Multiple Countries", "Iceland", "Ireland", "Italy", "Liechtenstein", "Moldova", "Montenegro", "Norway", "Portugal", "Romania", "Spain", "Switzerland", "United Kingdom of Great Britain & Northern Ireland", "Syria", "Multiple", "Kyrgyzstan", "Burma", "Bangledesh", "Krygyz Republic", "Russia", "Vanuatu", "Britain & Northern Ireland", "Côte d'Ivoire", "Fiji", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "Palau", "Samoa", "Slovakia", "Tonga", "Tuvalu", "United States of America", "Palestine", "Gambia"]

CATEGORIES.each     { |title| Category.create!(title: title.strip) }
JURISDICTIONS.each  { |title| Jurisdiction.create!(title: title.strip) }
LANGUAGES.each      { |title| Language.create!(title: title.strip) }
TOPICS.each         { |title| Topic.create!(title: title.strip) }
COUNTRIES.each      { |title| Country.create!(title: title.strip) }

Responsibility.create!(title: 'Admin', locked: true)
Responsibility.create!(title: 'Public', locked: true)

@user = User.create!(
  first_name: 'Eric',
  last_name: 'Hainer',
  email: 'eric@ckdtech.co',
  password: Rails.env.development? ? 'password' : Rails.application.credentials.admin[:password],
  password_confirmation: Rails.env.development? ? 'password' : Rails.application.credentials.admin[:password],
  confirmed_at: Time.now
)

@user.responsibilities << Responsibility.find_by(title: 'Admin')
@user.responsibilities << Responsibility.find_by(title: 'Public')
