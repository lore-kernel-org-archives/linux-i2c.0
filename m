From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
Date: Mon, 01 Dec 2008 16:51:47 -0800
Message-ID: <493486A3.4040502@consentry.com>
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <mailman.569.1227903153.29923.linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(replying to myself again)

I wrote:
> But the key difference is that we see a persistent failure, while the
> erratum only mentions a problem with "the next transaction".

I think the timeout recovery code is not adequate for these CPM errors,
and that is why a transient error becomes a persistent one.  The
function cpm_i2c_force_close in i2c-cpm.c sends a CPM_CR_CLOSE_RX_BD
command, which will abort any receive transaction in progress, but if
it's the transmit phase that got the CPM hung up, there is no code to
abort that (and there does not exist a CP command to do so, as far as
I can tell).

So the I2C disable/enable seems to be an appropriate fix for the
persistent failure part of the problem.  Again, this doesn't explain
how it gets hung up the first time.

					-=] Mike [=-
