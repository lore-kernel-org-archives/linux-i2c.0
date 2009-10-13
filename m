From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] i2c-bfin-twi: add debug output
	for error status
Date: Tue, 13 Oct 2009 19:18:08 -0400
Message-ID: <8bd0f97a0910131618r6db22d14n178e01a95a823b31@mail.gmail.com>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
	<1254973096-4391-2-git-send-email-vapier@gentoo.org> <20091013225438.GD13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091013225438.GD13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 13, 2009 at 18:54, Ben Dooks wrote:
> On Wed, Oct 07, 2009 at 11:38:16PM -0400, Mike Frysinger wrote:
>> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> Add some debug() code to decode the error register.
>
> are you sure you want such verbose debug, if someone issues a bus-scan
> then you'll be in for a treat of debuggyness.

if the user asked for debugging output, then they'll get debugging
output.  it isnt like this output will show up randomly.
-mike
