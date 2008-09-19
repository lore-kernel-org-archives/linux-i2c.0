From: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: pca9665
Date: Fri, 19 Sep 2008 08:37:25 -0300
Message-ID: <48D38EF5.60303@gamic.com>
References: <48D12295.8080008@gamic.com> <20080919100819.GC4307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080919100819.GC4307-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


Wolfram Sang wrote:
> Hello Marco,
>
> sorry for the late reply, I had to work on other parts first.
>   
No problem.
> On Wed, Sep 17, 2008 at 12:30:29PM -0300, Marco Aurelio da Costa wrote:
>
>   
>> I looked into the code for i2c-algo-pca.c and, if I don't want to 
>> implement the buffered mode (I can live without it for a while),
>>     
>
> But it may be worth to already get a rough idea if the buffered mode
> will fit into this algorithm at all.
>   
I will have to understand the buffered mode first, but at worse I will 
have to check which mode is being used and add another logic path.
>   
>> only changes I need to do are:
>> 1. Implement the reset via parallel bus.
>>     
>
> I can't see this point right now. The algorithm expects a reset routine
> from the driver using the algorithm; this should be flexible enough, no?
> Or do you mean you also want to share i2c-pca-platform.c among those two
> chips. Then it's correct to change it there. Otherwise, please enlighten
> me, it's been some time :)
>   
My ideas was to share the platform and the isa code. This is easy 
enough. For the PCA9665, the platform will not define the reset 
function, and the algorithm will not even try use it.
>   
>> 2. Change the way the i2c clock rate is treated, by passing the 
>> frequency directly instead of an index.
>>     
>
> Yup, this has to be generalized between these two.
>   
I can do that then. We should then pass the frequency. For the 9564, I 
will just accept the chip defined frequencies.
>   
>> After this, this module could handle both chips. I need your advice:
>> Should I just duplicate all code and make the changes to this new algo 
>> or should I add a chip_type field to i2c_algo_pca_data and handle the 
>> chip on the existing algo code?
>>     
>
> Concerning the algorithm, I'd really go for the latter. It is easier to
> maintain if there will be bugfixes to the state-machine, for example.
> And they seem to be similar enough (perhaps modulo the buffered mode,
> which I didn't look at so far).
>   
That is also my view. I will start coding, and will send you the patch 
for review later.
> All the best,
>
>    Wolfram
>
>   
Regards,

Marco


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
