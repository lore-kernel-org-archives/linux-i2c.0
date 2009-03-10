From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Tue, 10 Mar 2009 16:31:03 +0530
Message-ID: <5d5443650903100401j35f13459kcc03adb7dc7e9297@mail.gmail.com>
References: <20090306160042.GA17800@buzzloop.caiaq.de>
	 <20090307115449.32f0ab26@hyperion.delvare>
	 <20090307120631.GA25276@buzzloop.caiaq.de>
	 <20090307130818.367bcaad@hyperion.delvare>
	 <20090309210901.GC31367@buzzloop.caiaq.de>
	 <20090310095655.3850f0d5@hyperion.delvare>
	 <20090310090007.GB3263@buzzloop.caiaq.de>
	 <20090310111014.523df33e@hyperion.delvare>
	 <20090310102534.GC9564@buzzloop.caiaq.de>
	 <20090310114011.012d3fcc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090310114011.012d3fcc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

>
> I did not have the time to review it and will not have the time in a
> near future, sorry.
>
> There is a reason why I am trying to move these misc drivers outside of
> my maintenance area... Which basically means that you are totally free,
> and actually encouraged, to try to get your driver merged by another
> maintainer if I am too slow for you.
>

My suggestion would be get this driver in mainline through -mm tree
(cc akpm and linux-kernel) or Ben does the review and merge it from
his tree. It is better not to wait for IIO to get merged.

Please re-submit your patch to linux-kenel with creating
Documentation/misc directory.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
