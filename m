From: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than	NULL
Date: Mon, 04 May 2009 09:58:28 +1000
Message-ID: <49FE2FA4.6090109@elphinstone.net>
References: <49EDC0BE.7040505@elphinstone.net> <E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org> <20090422215646.GA19997@trinity.fluff.org> <AAD6564F-9D99-492B-8364-10A652F990DF@kernel.crashing.org> <20090503222352.GB5750@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090503222352.GB5750-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linuxppc-dev Development <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Wed, Apr 29, 2009 at 08:43:14AM -0500, Kumar Gala wrote:
>> On Apr 22, 2009, at 4:56 PM, Ben Dooks wrote:
>>
>>> On Tue, Apr 21, 2009 at 10:11:51AM -0500, Kumar Gala wrote:
>>>> On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:
>>>>
>>>>> Recent DMA changes result in a BUG() when NULL is passed to
>>>>> dma_alloc_coherent in place of a device.
>>>>>
>>>>> Signed-off-by: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
>>>>> ---
>>>>>
>>>>> This patch fixes the BUG() during boot that has appeared during the
>>>>> 2.6.30 window. It has been tested and appears correct on my 8280  
>>>>> based
>>>>> board.
>>>>> Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it
>>>>> belongs.
>>>>>
>>>>>
>>>>> drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
>>>>> 1 files changed, 8 insertions(+), 6 deletions(-)
>>>> Acked-by: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
>>>>
>>>> Ben, I'm expecting you to pick this up unless you tell me otherwise.
>>> Yes.
>> This go in yet?
> 
> I've had to do a manual apply due to some changes in the
> driver, so can someone please do a build of my git tree
> at:
> 
> git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630-rc5
> 
> or tell me which arch and defconfig to build.
> 

Fails to build, due to a typo.  Once fixed (diff below), it builds
and tests OK on my MPC8280 based hardware

Thanks.

Mark

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index b4c0448..b5db8b8 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -585,7 +585,7 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
  out_muram:
         for (i = 0; i < CPM_MAXBD; i++) {
                 if (cpm->rxbuf[i])
-                       dma_free_coherent(&cpm->ofdev->devL, CPM_MAX_READ + 1,
+                       dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
                                 cpm->rxbuf[i], cpm->rxdma[i]);
                 if (cpm->txbuf[i])
                         dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
