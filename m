From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
Date: Wed, 4 Apr 2018 10:13:19 +0200
Message-ID: <a6218454-d44c-7888-2688-d24bf5bc97f4@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
 <20180325181600.vehqe3xcx55qxtd7@katana>
 <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
 <20180403152604.udgh4v2erpsupgo3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403152604.udgh4v2erpsupgo3@ninjato>
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
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 04/03/2018 05:26 PM, Wolfram Sang wrote:
> On Mon, Mar 26, 2018 at 10:41:51AM +0200, Pierre Yves MORDRET wrote:
>>
>>
>> On 03/25/2018 08:16 PM, Wolfram Sang wrote:
>>> On Wed, Mar 21, 2018 at 05:48:56PM +0100, Pierre-Yves MORDRET wrote:
>>>> This patch adds slave support for I2C controller embedded in STM32F7 SoC
>>>>
>>>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>>>
>>> Looks OK from a first look. What kind of tests did you do?
>>
>> As mentioned for 10-bit, I'm using 2 I2C instances from the SoC.
>> Here are the tests I dit:
>>  - Master/slave send in 7 and 10 bits
>>  - master/slave recv in 7 and 10 bits
>>  - E2PROM Read/Write
> 
> As far as I understand the code now, both instances can be master /
> slave simultanously on the same bus?
> 

Correct.
