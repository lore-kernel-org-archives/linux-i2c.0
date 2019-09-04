From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: stm32f7: Make structure stm32f7_i2c_algo constant
Date: Wed, 4 Sep 2019 09:47:07 +0200
Message-ID: <662b171f-37e2-f58e-3e05-41a52737b1f3@st.com>
References: <20190815055857.1944-1-nishkadg.linux@gmail.com>
 <20190903180552.GI2171@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190903180552.GI2171@ninjato>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

Sorry for the delay.

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

BR

On 9/3/19 8:05 PM, Wolfram Sang wrote:
> On Thu, Aug 15, 2019 at 11:28:57AM +0530, Nishka Dasgupta wrote:
>> Static structure stm32f7_i2c_algo, of type i2c_algorithm, is used only
>> when it is assigned to constant field algo of a variable having type
>> i2c_adapter. As stm32f7_i2c_algo is therefore never modified, make it
>> const as well to protect it from unintended modification.
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
> 
> Are you guys okay with this patch?
> 
>>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
>> index 266d1c269b83..d36cf08461f7 100644
>> --- a/drivers/i2c/busses/i2c-stm32f7.c
>> +++ b/drivers/i2c/busses/i2c-stm32f7.c
>> @@ -1809,7 +1809,7 @@ static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
>>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>>  }
>>  
>> -static struct i2c_algorithm stm32f7_i2c_algo = {
>> +static const struct i2c_algorithm stm32f7_i2c_algo = {
>>  	.master_xfer = stm32f7_i2c_xfer,
>>  	.smbus_xfer = stm32f7_i2c_smbus_xfer,
>>  	.functionality = stm32f7_i2c_func,
>> -- 
>> 2.19.1
>>
