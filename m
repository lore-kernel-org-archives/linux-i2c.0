From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Date: Wed, 29 Apr 2009 08:43:14 -0500
Message-ID: <AAD6564F-9D99-492B-8364-10A652F990DF@kernel.crashing.org>
References: <49EDC0BE.7040505@elphinstone.net>
	<E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
	<20090422215646.GA19997@trinity.fluff.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090422215646.GA19997@trinity.fluff.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>, linux-i2c@vger.kernel.org, Mark Ware <mware@elphinstone.net>
List-Id: linux-i2c@vger.kernel.org


On Apr 22, 2009, at 4:56 PM, Ben Dooks wrote:

> On Tue, Apr 21, 2009 at 10:11:51AM -0500, Kumar Gala wrote:
>>
>> On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:
>>
>>> Recent DMA changes result in a BUG() when NULL is passed to
>>> dma_alloc_coherent in place of a device.
>>>
>>> Signed-off-by: Mark Ware <mware@elphinstone.net>
>>> ---
>>>
>>> This patch fixes the BUG() during boot that has appeared during the
>>> 2.6.30 window. It has been tested and appears correct on my 8280  
>>> based
>>> board.
>>> Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it
>>> belongs.
>>>
>>>
>>> drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
>>> 1 files changed, 8 insertions(+), 6 deletions(-)
>>
>> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> Ben, I'm expecting you to pick this up unless you tell me otherwise.
>
> Yes.

This go in yet?

- k
