From: Henri Kjellberg <henrikjellberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C Combined Transactions in Linux
Date: Sat, 10 Sep 2011 14:45:37 -0500
Message-ID: <CAFfjFp1KAmr2w=0Nwt1FtvYSNb7CJ59AHJtXmnnpat-PdyvHzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Greetings Friends,
I am looking for a way to perform combined transactions over I2C in
Linux. The structure of the message I need to send is as follows. The
slave responds in the brackets.

START
Slave Address, Write
[ACK]
Data
[ACK]
Data
[ACK]
...
FEND
START
Slave Address, Write
[Data]
ACK
[Data]
ACK
...
[FEND]
ACK
STOP

Here, FEND is a special end of message byte defined in a manner
similar to the SLIP encapsulation. It does not appear that I can use
the i2c_smbus_block_process_call because it requires the first data
byte to be the message length. Is there any way to send these sorts of
combined transaction in Linux without using the smbus interface?

Best,
Henri Kjellberg
UT-Austin
Satellite Design Laboratory
