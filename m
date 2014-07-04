From: Michael Post <michael_post-S0/GAf8tV78@public.gmane.org>
Subject: Re: Driver-Support of I2C_M_RECV_LEN
Date: Fri, 04 Jul 2014 09:39:11 +0200
Message-ID: <53B65A1F.7000501@web.de>
References: <53A42321.5020701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A42321.5020701-S0/GAf8tV78@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello together,

Am 20.06.14 14:03, schrieb Michael Post:
> Hello,
> 
> in the documentation i found at
> http://ww2.cs.fsu.edu/~rosentha/linux/2.6.26.5/docs/DocBook/kernel-api/re1222.html
> the following sentence:
> 
> "Note that using this function requires that the client's adapter
> support the I2C_FUNC_SMBUS_READ_BLOCK_DATA functionality. Not all
> adapter drivers support this; its emulation through I2C messaging relies
> on a specific mechanism (I2C_M_RECV_LEN) which may not be implemented."
> 
> The second sentence says that the mechanism I2C_M_RECV_LEN is not all
> over implemented.
> 
> How i can figure out whether this mechanism will be provided of my driver?
> What is the alternative of using the function i2c_smbus_read_block_data?

does nobody has any clue or hints for me?
Maybe there is an other mailinglist i can ask?

Thanks a lot,

Michael
