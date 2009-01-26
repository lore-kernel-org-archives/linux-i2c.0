From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Mon, 26 Jan 2009 13:06:20 -0800
Message-ID: <200901261306.21059.david-b@pacbell.net>
References: <1231177261.13443.20.camel@localhost.localdomain> <20090120114304.3b956189@hyperion.delvare> <1232951630.1329.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1232951630.1329.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 25 January 2009, Ed Swierk wrote:
> Here's another attempt at a patch for rtc-ds1307 that allows the driver
> to work with SMBus controllers like nforce2 that do not support i2c
> block transfers.  The byte-oriented compatibility routines now give up
> after 10 unsuccessful attempts to read or write a block of registers
> without conflict.
> 
> Signed-off-by: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Well, other than the *conceptual* ugliness of this (which
we seem to be stuck with, courtesy the board designer) ...
I have two patch format issues:

 - Always put a line of whitespace after variable
   declarations.

 - Include text like the above as part of the patch,
   even if you're stuck with a mailer that mangles
   non-attached text.

You're using Evolution, which is mentioned in the
Documentation/email-clients.txt file as having a
way (albeit awkward) to send normal patch email.

Given those changes:

  Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Thanks.

- Dave
