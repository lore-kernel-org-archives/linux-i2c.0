From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Date: Thu, 8 Oct 2009 08:37:16 -0600
Message-ID: <fa686aa40910080737l5b21654cw9c8f7426f9faf7c3@mail.gmail.com>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 8, 2009 at 8:04 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> As Anton introduced archdata support, I wondered if this is a suitable way to
> handle the platform_data/devicetree_property-dualism (at least for some
> drivers).

I think in general, this is the right direction; but I'm not convinced
that the right pattern or form has been found yet.  What I don't like
on this particular patch is that it still hooks of-specific stuff into
an arbitrary point in the probe routine.

I'd like to see some pattern for retrieving or populating a
platform_data structure when one isn't already provided, and
regardless of the data source.

So, I guess I'm saying that I agree with the approach, but I think a
better pattern would be to factor out all of the platform_data
fetching code into a separate function and keep probe() focused on
initializing the device based on a pdata structure returned by it.  It
will take a bit of experimentation to come up with the best form for
the pdata fetching function, but it will be better contained if it is
all at a single place.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
