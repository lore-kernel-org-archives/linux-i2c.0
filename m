From: Tao Ren <taoren@fb.com>
Subject: Re: [Potential Spoof] Re: [PATCH 1/2] i2c: aspeed: allow to customize
 base clock divisor
Date: Fri, 21 Jun 2019 22:21:23 +0000
Message-ID: <4b939e17-f364-4e63-f254-17bd531f75e6@fb.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
 <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
 <195bb56028d04001bbaf835cc17e032e@TWMBX02.aspeed.com>
 <56ff5fa8-091a-2cbc-dfa3-b912cf328695@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56ff5fa8-091a-2cbc-dfa3-b912cf328695@fb.com>
Content-Language: en-US
Content-ID: <C8E8C6F9194EF449903DD6E5BB84EF0B@namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Chen <ryan_chen@aspeedtech.com>, Brendan Higgins <brendanhiggins@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 6/20/19 1:13 AM, Tao Ren wrote:
> On 6/20/19 1:01 AM, Ryan Chen wrote:
>> Hello Tao,
>> 	Let me more clear. When you set (3, 15, 14) the device sometimes response nack. 
>> 	but when you set (4, 7, 7), the device always ack. Am I right? 
>> Ryan
> 
> Hello Ryan,
> 
> It's correct. We have seen the problem on 2 Facebook BMC platforms so far. Given the other ~10 Facebook BMC platforms are still running kernel 4.1 (with (4, 7, 7) settings), I'd assume more platforms will be impacted after upgrading to the latest kernel.
> 
> Thank you for spending time on this!

Just heads up Ryan and I are working with ODM vendors to collect scope output; will update back when we have new findings. Thank you all for spending time on this.


Cheers,

Tao
