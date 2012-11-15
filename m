From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: i2c-ocores: Add support for the GRLIB port of the controller and custom getreg and setreg functions
Date: Thu, 15 Nov 2012 10:02:35 +0100
Message-ID: <877gpn6xxw.fsf@dell.be.48ers.dk>
References: <1352834727-16368-1-git-send-email-andreas@gaisler.com>
	<1352834727-16368-3-git-send-email-andreas@gaisler.com>
	<87sj8d86lo.fsf@dell.be.48ers.dk> <50A4A9A9.5050903@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A4A9A9.5050903-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> (Andreas Larsson's message of
	"Thu, 15 Nov 2012 09:36:57 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:

Hi,

 >> Adding a type define (TYPE_OCORES / TYPE_GRLIB) and a 2nd
 >> of_device_id entry with .data = TYPE_GRLIB, and then using that in
 >> the probe routine would be nicer. Have a look at i2c-at91.c for an
 >> example of a driver doing something like that.

 Andreas> Yes, that is a good idea. Do you think casting to and from
 Andreas> void * in the following solution is too ugly and rather have a
 Andreas> struct pointed to, or do you think that would be unnecessary?

I find the casting OK.

Thanks.

-- 
Bye, Peter Korsgaard
