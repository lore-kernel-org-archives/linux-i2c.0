From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Date: Thu, 31 Jul 2008 11:31:44 -0600
Message-ID: <fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
References: <488982B5.4070102@grandegger.com> <48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4891F4D8.9090905-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 31, 2008 at 11:22 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
> Jon Smirl wrote:
>>
>> On 7/31/08, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>>>
>>> Grant Likely wrote:
>>>
>>>> On Fri, Jul 25, 2008 at 11:19:41AM -0500, Timur Tabi wrote:
>>>>
>>>>> Wolfgang Grandegger wrote:
>>>>>
>>>>>
>>>>>> I know but we still need an algorithm for MPC52xx and MPC82xx as well.
>>>>>>
>>>>> That's true, but I still think hard-coding values of DFSR and FDR in
>>>>> the
>>>
>>> device
>>>>>
>>>>> tree is not a good way to do this.
>>>>>
>>>> I agree, it should encode real frequencies, not raw register values.
>>>>
>>>  Digging deeper I'm frightened by plenty of platform specific code. We
>>> would
>>> need:
>>>
>>>  - one table of divider,fdr,dfsr values for the MPC82/3/5/6xx processors
>>>  (already available from Timur's U-Boot implementation)
>>>
>>>  - one table of divider,fdr values for the MPC5200 rev A.
>>>
>>>  - one table of divider,fdr values for the MPC5200 rev B.
>>>  (the Rev. B has two more pre-scaler bits).
>>
>> Aren't the tables in the manual there just to make it easy for a human
>> to pick out the line they want? For a computer you'd program the
>> formula that was used to create the tables.
>
> I have the formulas to create the tables, also for the MPC5200 Rev. A and B.

Oh, hey, even better.

> That was not my point. I'm worried about arch specific code in i2c-mpc.c. It
> should go somewhere to arch/powerpc.

i2c-mpc *is* arch specific.  I really don't think you need to worry
about adding a block of code for each supported SoC family.  Just
change the of_match table to look something like this:

static const struct of_device_id mpc_i2c_of_match[] = {
	{.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200b_set_freq, },
	{.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200_set_freq, },
	{.compatible = "fsl,mpc8260-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
	{.compatible = "fsl,mpc8349-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
	{.compatible = "fsl,mpc8540-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
	{.compatible = "fsl,mpc8543-i2c", .data = fsl_i2c_mpc8xxx_div2_set_freq, },
	{.compatible = "fsl,mpc8544-i2c", .data = fsl_i2c_mpc8xxx_div3_set_freq, },

        /* keep this only for older device trees with some support
code to figure out
           what .data should have pointed to. */
	{.compatible = "fsl-i2c", },
	{},
};
MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
