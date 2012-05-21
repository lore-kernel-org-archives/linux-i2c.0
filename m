From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Howto compile py-smbus with python 3.2
Date: Mon, 21 May 2012 17:14:19 +0200
Message-ID: <20120521171419.2ef13147@endymion.delvare>
References: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08323B@011-DB3MPN1-023.MGDPHG.emi.philips.com>
	<DDF9A29ED50FA94F83C55CFA4BB8EF5F08A9BD@011-DB3MPN1-024.MGDPHG.emi.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08A9BD-8+ddyajbMjJjmjMfHwPPEFZafE0Mqj5e5/FHAH3NXZDDzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bernhard,

On Mon, 21 May 2012 15:10:38 +0000, Renz, Bernhard wrote:
> Hello,
> 
> I got it to work!
> With the following pages I did a conversion of py-smbus from Python2 to Python3:
> http://docs.python.org/release/3.1.5/extending/building.html#building
> http://python3porting.com/cextensions.html
> 
> Here is the smbusmodule.c, which is based on the i2c-tools-3.1.0 release, which compile with Python3:
> Hope maybe Khali can provide it for other developers on his repository....

I'll do if you provide your changes as a patch (use diff -ruNp). BTW I
hope that your changes do not break support for python version 2, a lot
of distributions are still shipping that so we can't break it.

Thanks,
-- 
Jean Delvare
