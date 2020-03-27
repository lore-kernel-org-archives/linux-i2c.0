From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH] i2c: i2c-st: fix missing struct parameter description
Date: Fri, 27 Mar 2020 08:47:01 +0000
Message-ID: <0b432170-8ae0-d5c3-7557-fe6d606782f7@st.com>
References: <20200326212243.17363-1-avolmat@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200326212243.17363-1-avolmat@me.com>
Content-Language: en-US
Content-ID: <679754E3029C214598936C34C70CF6F2@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alain Volmat <avolmat@me.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alain

On 3/26/20 10:22 PM, Alain Volmat wrote:
> Fix a missing struct parameter description to allow
> warning free W=1 compilation.
>
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  drivers/i2c/busses/i2c-st.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
> index 54e1fc8a495e..f7f7b5b64720 100644
> --- a/drivers/i2c/busses/i2c-st.c
> +++ b/drivers/i2c/busses/i2c-st.c
> @@ -434,6 +434,7 @@ static void st_i2c_wr_fill_tx_fifo(struct st_i2c_dev *i2c_dev)
>  /**
>   * st_i2c_rd_fill_tx_fifo() - Fill the Tx FIFO in read mode
>   * @i2c_dev: Controller's private data
> + * @max: Maximum amount of data to fill into the Tx FIFO
>   *
>   * This functions fills the Tx FIFO with fixed pattern when
>   * in read mode to trigger clock.

Reviewed-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
