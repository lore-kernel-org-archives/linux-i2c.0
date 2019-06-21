From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] i2c: bcm2835: Ensure clock exists when probing
Date: Fri, 21 Jun 2019 07:18:25 +0200
Message-ID: <4dc45e03-7c83-b0b9-7579-c06d028e0baa@gmx.net>
References: <20190621042626.19998-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621042626.19998-1-nh6z@nh6z.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com
List-Id: linux-i2c@vger.kernel.org

Hi Annaliese,

Am 21.06.19 um 06:26 schrieb Annaliese McDermond:
> Probe function fails to recognize that upstram clock actually
s/upstram/upstream/
> doesn't yet exist because clock driver has not been initialized.
> Actually try to go get the clock and test for its existence
> before trying to set up a downstream clock based upon it.
>
> This fixes a bug that causes the i2c driver not to work with
> monolithic kernels.

I suggest to split the change into 2 patches (first reorder probing,
second clock) with a small cover letter. This makes the changes more
obvious and easier to review. Please also add a Fixes tags to see the
related commit.

Btw please use my new maintainer mail address

Thanks Stefan
