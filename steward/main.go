package main

import (
	"bufio"
	"fmt"
	"net/textproto"
	"regexp"
)

func main() {
	var msg = regexp.MustCompile(`PRIVMSG`)

	bot := NewBot()
	conn, err := bot.Connect()
	if err != nil {
		panic(err)
	}
	bot.Cmd("USER %s 8 * :%s", bot.nick, bot.nick)
	bot.Cmd("NICK %s", bot.nick)
	bot.Cmd("JOIN %s", bot.channel)
	defer conn.Close()

	reader := bufio.NewReader(conn)
	tp := textproto.NewReader(reader)
	for {
		line, err := tp.ReadLine()
		if err != nil {
			break
		}

		if msg.MatchString(line) {
			bot.Cmd("PRIVMSG %s :%s", bot.channel, line)
		}
		fmt.Printf("%s\n", line)
	}
}
