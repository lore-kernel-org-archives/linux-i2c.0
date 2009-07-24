From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Fri, 24 Jul 2009 11:14:22 -0700
Message-ID: <4A69F9FE.4060800@boundarydevices.com>
References: <1247643267.5981.82.camel@localhost.localdomain> <4A5E0E98.2030108@boundarydevices.com> <A69FA2915331DC488A831521EAE36FE40144FDB54B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE40144FDB54B-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Karicheri, Muralidharan wrote:
> Troy,
> <Snip>
> 
>> I personally like the idea behind this patch. But I have
>> heard others argue against it. But it is not related to the
>> ^C issue others have mentioned.That should not happen in
>> the GIT kernel.
>>
> I do get this ^c timeout issue in DM6446 and DM355. I have the video loopback application running that uses tvp5146 to capture from a video source. When I kill the application it starts giving the error while
> the tvp5146 driver tries to send i2c commands to stop capture at tvp5146.
> But in this case, it works again when the application is run again. But when I have mt9t031 connected and I do the same thing, it also fails with timeout when application is killed. But it never recovers and I have to reboot the board to recover from the error. So what you mean by "That should not happen in the GIT kernel" ?
> 
> Could you explain please?
> 
> Murali
> 
please see commit 5a0d5f5ffa5d294d895ef54fc220c6182db63998

I don't know if your issue has the same root cause.
