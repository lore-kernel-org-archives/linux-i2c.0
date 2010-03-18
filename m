From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Thu, 18 Mar 2010 10:01:22 +0100
Message-ID: <f69abfc31003180201m5c5e167enf8256c4843e0c6ba@mail.gmail.com>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	 <20100317135223.GD4153@pengutronix.de>
	 <f69abfc31003170826j18fa0fddq1c46b8bcebf75c57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f69abfc31003170826j18fa0fddq1c46b8bcebf75c57-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>> Could this be the reason for such behavior? Any idea?
>>
>> Can you set the algo-module parameter i2c_debug to 3 and post the log for the
>> transfer that failed, please?
>
> I've increased i2c_debug to 3 and now I get a lot of debug messages,
> but the error doesn't occur. These debug messages seem to influence
> the timing.

If I don't redirect syslog to a remote host I get i2c fail. So here you are:

=== START
STATE is 0x08
=== SLAVE ADDRESS 0x68+W=0xd0
STATE is 0x18
=== WRITE 0x00
STATE is 0x28
=== REPEATED START
STATE is 0x10
=== SLAVE ADDRESS 0x68+R=0xd1
STATE is 0x40
STATE is 0x50
=== READ 0x27 ACK
STATE is 0x50
=== READ 0x55 ACK
STATE is 0x50
=== READ 0x08 ACK
STATE is 0x50
=== READ 0x05 ACK
STATE is 0x50
=== READ 0x18 ACK
STATE is 0x50
=== READ 0x83 ACK
STATE is 0x58
=== READ 0x10 NACK
=== STOP
}}} transfered 2/2 messages. status is 0x58. control is 0x55
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
{{{ XFER 2 messages
    [00] WR 1 bytes to 0x68 [0xd0, 0x00]
    [01] RD 7 bytes from 0x68 [0xd1, ...]
STATE is 0xf8
=== START
STATE is 0x08
=== SLAVE ADDRESS 0x68+W=0xd0
STATE is 0x18
=== WRITE 0x00
STATE is 0x28
=== REPEATED START
STATE is 0x10
=== SLAVE ADDRESS 0x68+R=0xd1
STATE is 0x40
STATE is 0x50
=== READ 0x27 ACK
STATE is 0x50
=== READ 0x55 ACK
STATE is 0x50
=== READ 0x08 ACK
STATE is 0x50
=== READ 0x05 ACK
STATE is 0x50
=== READ 0x18 ACK
STATE is 0x50
=== READ 0x83 ACK
STATE is 0x58
=== READ 0x10 NACK
=== STOP
}}} transfered 2/2 messages. status is 0x58. control is 0x55
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
{{{ XFER 2 messages
    [00] WR 1 bytes to 0x68 [0xd0, 0x00]
    [01] RD 7 bytes from 0x68 [0xd1, ...]
STATE is 0xf8
=== START
STATE is 0x08
=== SLAVE ADDRESS 0x68+W=0xd0
STATE is 0x18
=== WRITE 0x00
STATE is 0x28
=== REPEATED START
STATE is 0x10
=== SLAVE ADDRESS 0x68+R=0xd1
STATE is 0x40
STATE is 0x50
=== READ 0x27 ACK
STATE is 0x50
=== READ 0x55 ACK
STATE is 0x50
=== READ 0x08 ACK
STATE is 0x50
=== READ 0x05 ACK
STATE is 0x50
=== READ 0x18 ACK
STATE is 0x50
=== READ 0x83 ACK
STATE is 0x58
=== READ 0x10 NACK
=== STOP
}}} transfered 2/2 messages. status is 0x58. control is 0x55
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
{{{ XFER 2 messages
    [00] WR 1 bytes to 0x68 [0xd0, 0x00]
    [01] RD 7 bytes from 0x68 [0xd1, ...]
STATE is 0xf8
=== START
STATE is 0x08
=== SLAVE ADDRESS 0x68+W=0xd0
STATE is 0x18
=== WRITE 0x00
STATE is 0x28
=== REPEATED START
STATE is 0x10
=== SLAVE ADDRESS 0x68+R=0xd1
STATE is 0x40
STATE is 0x50
=== READ 0x27 ACK
STATE is 0x50
=== READ 0x55 ACK
STATE is 0x50
=== READ 0x08 ACK
STATE is 0x50
=== READ 0x05 ACK
}}} transfered 1/2 messages. status is 0x50. control is 0xcd
rtc-ds1307 0-0068: read error -121
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
i2c i2c-0: bus is not idle. status is 0x50
rtc-ds1307 0-0068: read error -11
i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
i2c i2c-0: bus is not idle. status is 0x50

As far as I can tell the last transaction lacks "=== STOP" state.

Regards,
Yegor
