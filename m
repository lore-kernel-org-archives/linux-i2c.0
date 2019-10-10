From: Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] i2c: aspeed: fix master pending state handling
Date: Thu, 10 Oct 2019 01:26:49 +0000
Message-ID: <43ab0316-78dd-b7b0-c04e-e039d38c3d45@fb.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <20191010003234.GA12710@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010003234.GA12710@google.com>
Content-Language: en-US
Content-ID: <3DC2428602E08C4F8C65A1DA359F1D88@namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Wolfram Sang <wsa@the-dreams.de>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cedric Le Goater <clg@kaod.org>
List-Id: linux-i2c@vger.kernel.org

On 10/9/19 5:32 PM, Brendan Higgins wrote:
> On Wed, Oct 09, 2019 at 02:20:34PM -0700, Jae Hyun Yoo wrote:
>> In case of master pending state, it should not trigger a master
>> command, otherwise data could be corrupted because this H/W shares
>> the same data buffer for slave and master operations. It also means
>> that H/W command queue handling is unreliable because of the buffer
>> sharing issue. To fix this issue, it clears command queue if a
>> master command is queued in pending state to use S/W solution
>> instead of H/W command queue handling. Also, it refines restarting
>> mechanism of the pending master command.
>>
>> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> We don't have any multi-master setups, can we get a Tested-by?

I've applied the patch to my tree and I'm looking for a minipack BMC
(milti-master) to test the patch. Will come back with results tomorrow.


Cheers,

Tao

> Wolfram, since this is a bugfix, can we get this in 5.4?
> 
> Thanks!
> 
