From: Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
Date: Thu, 20 Jun 2019 07:57:26 +0000
Message-ID: <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
Content-Language: en-US
Content-ID: <0FB3EA1C925D3F45868E5B7441BA38C2@namprd15.prod.outlook.com>
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

On 6/20/19 12:29 AM, Ryan Chen wrote:
> Hello Tao,
> 	Our recommend about clk divider setting is follow the datasheet clock setting table for clock divisor. 
> 
> Ryan  

Thanks Ryan for the response. Could you also share some recommendations/hints on how to solve the intermittent i2c transaction failures on Facebook AST2500 BMC platforms?

BTW, the patch is not aimed at modifying the existing formula of calculating clock settings in i2c-aspeed driver: people still get the recommended settings by default. The goal of the patch is to allow people to customize clock settings in case the default/recommended one doesn't work.


Cheers, 

Tao
