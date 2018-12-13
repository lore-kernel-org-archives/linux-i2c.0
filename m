From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Thu, 13 Dec 2018 17:32:27 +0800
Message-ID: <1544693547.11699.40.camel@mhfsdcap03>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181211202931.xav4gzi7rzh2scgx@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-12-11 at 21:29 +0100, Wolfram Sang wrote:
> > +  - ch-offset: base reg offset for multi-user.
> 
> What is "multi-user"? Why can't you add this offset to the reg-property
> directly?
> 

Thanks for your comment.
There are 3 channel in one MT8183 I3C controller, and every channel can
be used as an I2C controller.
Take the following diagram as example:
If use I3C channels as I2C bus,
1. CH-A/B/C offset are different;
2. If use CH-B or CH-A as I2C, they must config registers which's
address are in CH-A.
 ____________________________________
|     ________                       |
|    |        |<--- offset:0x00      |
|    |  CH-A  |                      |
|    |________|                      |
|    |        |<--- offset:0x100     |
|    |  CH-B  |                      |
|    |________|                      |
|    |        |<--- offset:0x200     |
|    |  CH-C  |                      |
|    |________|                      |
|____________________________________|
        one I3C controller               

Because of CH-B/CH-C depend on CH-A's register, it can't add offset to
reg-property directly.

MT8183 doesn't need to support muti-user according to the latest project
information, and I'll remove this feature from patches.

> > +  - mediatek,share-i3c: i3c controller can share i2c function.
> 
> Please explain in more detail? Is this an I3C controller?
> 

Yes, it is a i3c controller, and it is compatible with i2c. I only use
the feature of i2c, so I need a flag to do some extra settings.
