From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-ocores: Move grlib set/get functions into #ifdef CONFIG_OF block
Date: Mon, 19 Nov 2012 19:44:06 +0100
Message-ID: <87mwydl9ft.fsf@dell.be.48ers.dk>
References: <1353327468-9407-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353327468-9407-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> (Andreas
	Larsson's message of "Mon, 19 Nov 2012 13:17:48 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:

 Andreas> This moves the grlib set and get functions into the #ifdef
 Andreas> CONFIG_OF block to avoid warnings of unimplemented functions
 Andreas> when compiling with -Wunused-function when CONFIG_OF is not
 Andreas> defined.

 Andreas> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

-- 
Bye, Peter Korsgaard
