From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
 timing out.
Date: Mon, 03 Nov 2008 12:44:08 +0100
Message-ID: <490EE408.2050704@scram.de>
References: <490BA2E5.8010309@consentry.com> <20081103002328.GC30438@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081103002328.GC30438-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

> On Fri, Oct 31, 2008 at 05:29:25PM -0700, Mike Ditto wrote:
>> Make the driver report an ENXIO error immediately upon NAK instead of
>> waiting for another interrupt and getting a timeout.
>>
>> Signed-off-by: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>

Acked-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>

> It looks ok, I'll merge and push out to linus with the s3c fixes.

Thanks!

Jochen
