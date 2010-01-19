From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Tue, 19 Jan 2010 12:48:12 +0100
Message-ID: <20100119124812.345fe447@hyperion.delvare>
References: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
	<1263056154-20085-1-git-send-email-darkstar6262@gmail.com>
	<20100118124855.GB8036@sortiz.org>
	<20100118153624.GA13811@sortiz.org>
	<6cb013311001181323q79aba15dif165ff41d79734a7@mail.gmail.com>
	<20100119110916.GB554@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100119110916.GB554-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Samuel,

On Tue, 19 Jan 2010 12:09:17 +0100, Samuel Ortiz wrote:
> 2) Kconfig: we need to depend on I2C=y, to avoid the problematic case of
> having I2C_CORE=m and HTC_I2CPLD=y

??

There is no config option named I2C_CORE. The main option for I2C is,
well, I2C, and if you depend on I2C, then you can't be built into the
kernel if I2C is built as a module. What exact problem are you trying
to solve?

-- 
Jean Delvare
