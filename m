From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL 5.0 009/262] i2c: sis630: correct format strings
Date: Thu, 28 Mar 2019 11:07:44 +0100
Message-ID: <20190328100744.GB19456@atrey.karlin.mff.cuni.cz>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-9-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-9-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Louis Taylor <louis@kragniz.eu>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> From: Louis Taylor <louis@kragniz.eu>
> 
> [ Upstream commit 60f7691c624b41a05bfc3493d9b0519e7951b7ef ]
> 
> When compiling with -Wformat, clang warns:
> 
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
> 
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~

Warning with unsupported compiler; not a "serious bug".
	
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
