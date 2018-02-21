From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Wed, 21 Feb 2018 10:23:47 +0100
Message-ID: <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180221091130.4sdfnalrng4sd77i@ninjato>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

2018-02-21 10:11 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Mon, Jan 29, 2018 at 05:56:52PM +0100, Bartosz Golaszewski wrote:
>> 2018-01-29 17:17 GMT+01:00 Rob Herring <robh@kernel.org>:
>> > On Tue, Jan 16, 2018 at 05:06:15PM +0100, Peter Rosin wrote:
>> >> Makes them easier to find.
>> >>
>> >> Signed-off-by: Peter Rosin <peda@axentia.se>
>> >> ---
>> >>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > This one should go into 4.16. I can apply after rc1 or apply to tree
>> > with at24.txt changes queued.
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > Rob
>>
>> Wolfram,
>>
>> can you take this via the i2c tree for 4.16?
>
> I missed this mail because I leave at24 patches to you now.
> Please send pull requests for patches I shall take. Least room for
> confusion (I hope).
>

Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
one? It's part of a bigger series, do you want me to apply it to my
tree and provide you with an immutable branch?

Bart
