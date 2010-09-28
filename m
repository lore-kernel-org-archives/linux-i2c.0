From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [SOLVED] wnv_cs.c: i2c question
Date: Tue, 28 Sep 2010 22:37:54 +0200
Message-ID: <20100928203754.GA20730@comet.dominikbrodowski.net>
References: <20100927074549.GA32061@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100927074549.GA32061@comet.dominikbrodowski.net>
Sender: linux-media-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hey,

> as I recently obtained such a PCMCIA card, I try to revive the wnv_cs driver
> for Winnov Videum Traveler video cards. First (non-working, but compiling
> and able to access the EEPROM and to detect the decoder) results may be
> found at
> 
> http://git.kernel.org/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=shortlog;h=refs/heads/wnv
> 
> Now, I got a bit stuck at the i2c level -- do the following access functions
> look familiar to one of the i2c experts? If so, which algo driver is to be
> used? Is this an i2c_smbus_, or some very custom interface not worth
> converting to use the i2c subsystem? Many thanks!

inverting i2c_data and i2c_clock did the trick.

Best,
	Dominik
