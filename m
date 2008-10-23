From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [i2c] [PATCH v7] Add ov772x driver
Date: Thu, 23 Oct 2008 12:26:13 +0900
Message-ID: <aec7e5c30810222026g4622aafcrf70cde31bcb0c602@mail.gmail.com>
References: <uhc77mucm.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <uhc77mucm.wl%morimoto.kuninori@renesas.com>
Content-Disposition: inline
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: khali@linux-fr.org, V4L <video4linux-list@redhat.com>, i2c@lm-sensors.org, mchehab@infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 20, 2008 at 7:09 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> This patch adds ov772x driver that use soc_camera framework.
> It was tested on SH Migo-r board.
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> PATCH v6 -> v7

This works just fine on my Migo-R board as well. Much better than my
old soc_camera_platform hack.

Acked-by: Magnus Damm <damm@igel.co.jp>

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
