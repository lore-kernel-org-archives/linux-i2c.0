From: folkert <folkert-Beo89p9qyDM6GGFevw1D/A@public.gmane.org>
Subject: read/write from/to an i2c device from linux
Date: Sat, 12 Sep 2015 20:02:20 +0200
Message-ID: <20150912180220.GH25041@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

For fun I'm trying to achieve communication between a linux master
(raspberry pi) and an arduino slave over i2c.
This somewhat works. Somewhat because for example I occasionally get a
-1 return value on read().

What I'm doing is as follows:

- i'm "sending messages" to the arduino using regular write() calls. I
  do a write with in one go all data (so not sending 1 message with
  multiple writes). commands are in size somewhere between 1
  and 32 bytes

- after I've send a message to the arduino, it'll collect some data
  from an other source and put this in a send-buffer. Later on the
  master will fetch this data.
  The amount of data to be transmitted to the master is not always the
  same. Sometimes 6 bytes, sometimes 1204 bytes. Not much more because
  of RAM limits in the arduino.

- After a while (after sending the command to the arduino) I do a read()
  on the linux master to receive the data from the arduino. for this i
  have a 2KB buffer. so I do read(fd, buffer, 2048)
  Occasionally this read() returns a -1.

My questions now are:

- is what I'm doing here this supposed to work? e.g. sending messages
  in random size of 1...32 bytes (there's a 32 byte limit in the
  arduino for receiving), receiving data of random-size e.g. doing a
  read of 2KB and expecting that or less data

- how can I see if there's a device listening on an i2c address? should
  I do a write and see if this write succeeds? wrap it in a
  poll(POLLOUT) first?

- how can I see when I do a read() from a device, if there is data? do
  a poll(POLLIN) and then a read?

- in what situations will the read() return a -1? if there are multiple
  situations: how can I see which situation triggered it?


regards

Folkert van Heusden
