# Initialize all our fun messages

messages = {}
messages['initializing'] = ["Bzzt! I'm finding the things...",
                            "Bzzt! Crunching the numbers...",
                            "Bzzt! I'm on it...",
                            "Bzzt! Looking into it right now...",
                            "Bzzt! Counting contributions..."]
messages['error'] = [
  "I could not find the things. Plz help fix this by checking my logs :-)",
  "I'm terribly sorry, but I ran into an issue when crunching those numbers.
  Can you check my logs and fix me?",
  "Something broke :-/ Please help fix me by checking my logs"]

messages['org_name_reminders'] = [
  "*Hack Club",
  "Did you mean Hack Club?",
  "No hackEDU here! We're Hack Club now!"]

messages['bot_name_reminders'] = [
  "*Orpheus",
  "Did you mean me?",
  "No hubot here! I'm Orpheus now!"]

module.exports = messages
