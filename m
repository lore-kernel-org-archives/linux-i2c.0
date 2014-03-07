From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
Date: Fri, 7 Mar 2014 13:08:13 +0800
Message-ID: <05EF9B59-7009-49D2-B57F-5612C39F1FF0@jcrosoft.com>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320>
 <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
 <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com>
 <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Roszko <mark.roszko@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-i2c@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org> mailing list" <linux-arm-kernel@lists.infradead.org>, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org


On Mar 7, 2014, at 12:26 PM, Mark Roszko <mark.roszko@gmail.com> wrote:

> Unless I'm misunderstanding your reply, it doesn't need to be set on
> each i2c device. It's meant to be an option to override the currently
> hardcoded 100khz for all the at91 devices.

yes you do need to set it on each device

as in the DT you describe the hw you set the speed of each device and then the bus
based on the present device will use the appropriate one

Best Regards,
J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
