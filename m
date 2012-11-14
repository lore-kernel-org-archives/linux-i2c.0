From: Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Wed, 14 Nov 2012 09:10:33 +0530
Message-ID: <CAM4voa==f81W-pC80Q43NzvF6uXXVZmLH2_Ta4A3x3EuboQWVA@mail.gmail.com>
References: <1352182259-28903-1-git-send-email-a.kesavan@samsung.com>
	<CAM=Q2ctBMmg32-Dd6V5pwEEzxCnATs1se4RD_+zgLLOGohgSzw@mail.gmail.com>
	<CAM4voa=hnKR_ovUu_uzy8o5wQ2WXazKceLTWh=tj02YWRgRbYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM4voa=hnKR_ovUu_uzy8o5wQ2WXazKceLTWh=tj02YWRgRbYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Any comments on this fix ?

Abhilash
On Tue, Nov 6, 2012 at 1:08 PM, Abhilash Kesavan
<kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Shubhrajyoti,
>
> On Tue, Nov 6, 2012 at 11:42 AM, Shubhrajyoti Datta
> <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Tue, Nov 6, 2012 at 11:40 AM, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>> The I2C driver makes a gpio_request during initialization. This request
>>> happens again on resume
>>
>> Do you know why request and free is needed across the suspend and resume?
>
> Other than the way the code is structured where the same
> initialization code is called at
> probe and resume, there isn't a need for the request/free.
>
> Abhilash
