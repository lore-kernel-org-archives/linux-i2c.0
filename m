From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of: base: add function to get highest id of an
 =?iso-8859-1?Q?alias=0D?= stem
Date: Sat, 28 Mar 2015 13:20:49 +0000
Message-ID: <20150328132049.EDF7CC40869@trevor.secretlab.ca>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
	<1426177093-26820-2-git-send-email-wsa@the-dreams.de>
	<20150318124631.GB3580@katana>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150318124631.GB3580@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bob Feretich <bob.feretich@rafresearch.com>, Jean Delvare <jdelvare@suse.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 18 Mar 2015 13:46:31 +0100
, Wolfram Sang <wsa@the-dreams.de>
 wrote:
> On Thu, Mar 12, 2015 at 05:17:58PM +0100, Wolfram Sang wrote:
> > I2C supports adding adapters using either a dynamic or fixed id. The
> > latter is provided by aliases in the DT case. To prevent id collisions
> > of those two types, install this function which gives us the highest
> > fixed id, so we can then let the dynamically created ones come after
> > this highest number.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Applied to for-next, thanks!

Looks good to me to. Thanks for doing this. It should also be useful for
other devices.

g.
