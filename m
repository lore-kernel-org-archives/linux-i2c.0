From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: Re: Newbie: accessing i2c features through kernel functions
Date: Fri, 31 May 2013 16:56:20 +0200
Message-ID: <20130531165620.52a79500@crub>
References: <1369818463.42609.YahooMailNeo@web141202.mail.bf1.yahoo.com>
	<51A87235.2060702@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A87235.2060702-GANU6spQydw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: CF <cfoissac-GANU6spQydw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 31 May 2013 11:49:41 +0200
CF <cfoissac-GANU6spQydw@public.gmane.org> wrote:

> I'm requesting help. I am currently successfully using i2c-dev module.
> But i'm unable to drive i2c busses from kernel space as i'd do from
> userspace (with the use of open, read, write, ioctl functions). I can't
> logically acces glibc.
> 
> Can somebody point me how i could do from kernel space ? 

you need to get the I2C adapter for your bus using i2c_get_adapter()
and then send the I2C messages by i2c_transfer().

Anatolij
