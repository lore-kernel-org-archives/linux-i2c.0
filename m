From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] Add the of_find_i2c_device_by_node function
Date: Mon, 20 Oct 2008 02:03:52 +0400
Message-ID: <20081019220352.GA19539@oksana.dev.rtsoft.ru>
References: <20081019140040.32281.65209.stgit@terra>
	<20081019212034.GA8224@oksana.dev.rtsoft.ru>
	<9e4733910810191450t36cbe120y106d18f71cb3163b@mail.gmail.com>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e4733910810191450t36cbe120y106d18f71cb3163b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 19, 2008 at 05:50:15PM -0400, Jon Smirl wrote:
> On Sun, Oct 19, 2008 at 5:20 PM, Anton Vorontsov
> <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:
> > Hi Jon,
> >
> > On Sun, Oct 19, 2008 at 10:00:40AM -0400, Jon Smirl wrote:
> >> Add the of_find_i2c_device_by_node function. This allows you to follow
> >> a reference in the device tree to an i2c device node and then locate
> >> the linux device instantiated by the device tree. Example use, an i2s
> >> codec controlled by i2c. Depends on patch exporting i2c root bus symbol.
> >>
> >> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Few comments are below.
> >
> >> ---
> >>  drivers/of/of_i2c.c |   28 ++++++++++++++++++++++++----
> >>  1 files changed, 24 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> >> index 6a98dc8..ba7b394 100644
> >> --- a/drivers/of/of_i2c.c
> >> +++ b/drivers/of/of_i2c.c
> >> @@ -19,7 +19,7 @@
> >>  void of_register_i2c_devices(struct i2c_adapter *adap,
> >>                            struct device_node *adap_node)
> >>  {
> >> -     void *result;
> >> +     struct i2c_client *i2c_dev;
> >>       struct device_node *node;
> >>
> >>       for_each_child_of_node(adap_node, node) {
> >> @@ -41,18 +41,38 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >>
> >>               info.addr = *addr;
> >>
> >> -             request_module(info.type);
> >> +             request_module("%s", info.type);
> >
> > Patch description doesn't mention this change.
> 
> Patches for this have been posted before by other people and they
> aren't making it in.
> 
> This is the original mail....
> http://lkml.org/lkml/2008/6/13/290
> http://lkml.org/lkml/2008/6/12/8
> I can't find the ones patching i2c.

Well, I didn't disagree with the change. I think this is good change
(and good catch, btw).

Just mention it in the patch description (or better yet, you could send
a separate patch for this particular issue, it seems quite serious).


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
