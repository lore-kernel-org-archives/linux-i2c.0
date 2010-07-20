From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 20 Jul 2010 11:13:48 +0200
Message-ID: <87fwzejz1v.fsf@macbook.be.48ers.dk>
References: <1278285584-13632-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278285584-13632-1-git-send-email-peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
	(Peter Korsgaard's message of "Mon, 5 Jul 2010 01:19:44 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org> writes:

 Peter> Add an i2c bus driver providing virtual i2c busses using a hardware
 Peter> MUX sitting on a master bus and controlled through gpio pins.

 Peter> E.G. something like:

 Peter>   ----------              ----------  Virtual bus 1   - - - - -
 Peter>  |          | SCL/SDA    |          |-------------- |           |
 Peter>  |          |------------|          |
 Peter>  |          |            |          | Virtual bus 2 |           |
 Peter>  |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
 Peter>  |          |------------|          |               |           |
 Peter>  |          |            |          | Virtual bus M
 Peter>  |          |            |          |---------------|           |
 Peter>   ----------              ----------                  - - - - -

 Peter> SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
 Peter> according to the settings of the GPIO pins 1..N.

 Peter> Signed-off-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

Comments?

-- 
Bye, Peter Korsgaard
