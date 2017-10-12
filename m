From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
Date: Thu, 12 Oct 2017 11:31:15 +0200
Message-ID: <990c3275-35b3-68da-453c-d1a80e867df7@st.com>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
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
To: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 10/11/2017 01:53 PM, Radoslaw Pietrzyk wrote:
> 	Do not read data on RXNE but on BTF only due to HW
> 	synchronisation problems and NACKing read data too early.
> 	It was found during testing of stmpe811 touchscreen driver.
> 

Would you mind to explain what is behind "hw sync issue" you've seen ?

> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> ---
>  drivers/i2c/busses/i2c-stm32f4.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> index 4ec1084..86bcf4c 100644
> --- a/drivers/i2c/busses/i2c-stm32f4.c
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -409,16 +409,9 @@ static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
>  	 * So, here we just disable buffer interrupt in order to avoid another
>  	 * system preemption due to RX not empty event.
>  	 */
> -	case 2:
> -	case 3:
> +	default:
>  		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
>  		break;
> -	/*
> -	 * For N byte reception with N > 3 we directly read data register
> -	 * until N-2 data.
> -	 */
> -	default:
> -		stm32f4_i2c_read_msg(i2c_dev);
>  	}
>  }
>  
> @@ -470,8 +463,6 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
>  		 */
>  		reg = i2c_dev->base + STM32F4_I2C_CR1;
>  		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> -		stm32f4_i2c_read_msg(i2c_dev);
> -		break;
>  	default:
>  		stm32f4_i2c_read_msg(i2c_dev);
>  	}
> 
