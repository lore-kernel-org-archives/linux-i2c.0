From: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: imx: add slave support
Date: Tue, 26 Jan 2016 17:13:43 +0300
Message-ID: <56A77F17.6090903@dev.rtsoft.ru>
References: <201601260255.x4ozgiHe%fengguang.wu@intel.com>
 <56A72CC0.1070207@dev.rtsoft.ru> <20160126083609.GB2190@katana>
 <56A7424F.40303@dev.rtsoft.ru> <56A776A9.1070508@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A776A9.1070508@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Maxim Syrchin <syrchin@dev.rtsoft.ru>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Vladimir,

Thanks for the comment.
We are both the authors of this patch.

> Could you please squash the changes (care about indentation in Kconfig also)
> and resend it as v2 (probably you may want to wait for review comments some
> more time)?
I suppose that after review, there will be many other things to fix in 
this patch.
Thus, if you don`t mind, we wont send fixed version for now.




On 26.01.2016 16:37, Vladimir Zapolskiy wrote:
> On 26.01.2016 11:54, Dmitriy Baranov wrote:
>> Sorry, we should have added selecting this in our patch.
>> The following fixes it:
>>
>> Subject: [PATCH] Select I2C_SLAVE for i2c-imx driver because it uses the
>> generic slave interface.
>>
>> Signed-off-by: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
>> Signed-off-by: Maxim Syrchin <syrchin@dev.rtsoft.ru>
>> ---
>>    drivers/i2c/busses/Kconfig | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 0299dfa..bc7cbfd 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -587,6 +587,7 @@ config I2C_IMG
>>    config I2C_IMX
>>        tristate "IMX I2C interface"
>>        depends on ARCH_MXC || ARCH_LAYERSCAPE
>> +    select I2C_SLAVE
>>        help
>>          Say Y here if you want to use the IIC bus controller on
>>          the Freescale i.MX/MXC or Layerscape processors.
>>
> Could you please squash the changes (care about indentation in Kconfig also)
> and resend it as v2 (probably you may want to wait for review comments some
> more time)?
>
> Two more formal questions, why patch submitter's Signed-off-by: is not the
> last in the list and why Maxim has Signed-off-by tag here? Who is the author
> of the change?
>
> See Documentation/SubmittingPatches "Sign your work" for details.
>
> Best wishes,
> Vladimir
