From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
 timing out.
Date: Sun, 02 Nov 2008 19:50:20 -0800
Message-ID: <490E74FC.4060106@consentry.com>
References: <490BA2E5.8010309@consentry.com> <20081103002328.GC30438@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081103002328.GC30438-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
>> When reading from a device that is not present or declines to respond
>> to, e.g., a non-existent register address, CPM immediately reports a
>> NAK condition in the TxBD, but the driver kept waiting until a timeout,
>> which takes 1 second and causes an ugly console error message.
> 
> hmm, that block of text could probably go into the patch description.

It's certainly fine with me if you want to include it.  I was just
trying, perhaps inappropriately, to separate the "bug report" from the
"description of the change".

					-=] Mike [=-
