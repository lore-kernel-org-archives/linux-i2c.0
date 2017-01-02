From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Intel-gfx] [RFC 3/4] drm/i915: valleyview: Make intel_set_rps
 get FORCEWAKE_MEDIA
Date: Mon, 2 Jan 2017 13:40:07 +0100
Message-ID: <6e0133ab-da7d-a9b9-1b8b-53e5b3eb9d7b@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-4-hdegoede@redhat.com>
 <20170101202400.GG13154@nuc-i3427.alporthouse.com>
 <556a9c6d-33ba-0047-82df-8bf75e09e208@redhat.com>
 <20170102113759.GC16295@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755445AbdABMkK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 2 Jan 2017 07:40:10 -0500
In-Reply-To: <20170102113759.GC16295@nuc-i3427.alporthouse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org

Hi,

On 02-01-17 12:37, Chris Wilson wrote:
> On Sun, Jan 01, 2017 at 09:48:53PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01-01-17 21:24, Chris Wilson wrote:
>>> On Sun, Jan 01, 2017 at 09:14:02PM +0100, Hans de Goede wrote:
>>>> All callers of valleyview_set_rps() get at least FORCEWAKE_MEDIA, except
>>>> for intel_set_rps(). Since intel_set_rps can for example be called from
>>>> sysfs store functions, there is no guarantee this is already done, so add
>>>> an intel_uncore_forcewake_get(FORCEWAKE_MEDIA) call to intel_set_rps.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> drivers/gpu/drm/i915/intel_pm.c | 9 +++++++--
>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
>>>> index 4b12637..cc4fbd7 100644
>>>> --- a/drivers/gpu/drm/i915/intel_pm.c
>>>> +++ b/drivers/gpu/drm/i915/intel_pm.c
>>>> @@ -5096,9 +5096,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
>>>>
>>>> void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
>>>> {
>>>> -	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
>>>> +	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
>>>> +		/* Wake up the media well, as that takes a lot less
>>>> +		 * power than the Render well.
>>>> +		 */
>>>> +		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
>>>> 		valleyview_set_rps(dev_priv, val);
>>>
>>> Both powerwells are woken for rps. (Taking one but not the other has no
>>> benefit, and very misleading.)
>>
>> The comment on why FORCEWAKE_MEDIA is used + code is copy pasted from the
>> existing code in vlv_set_rps_idle().
>
> It's not correct there either...
>
>>> The forcewake is already held by the
>>> lower level routines, taking the wakelock in the caller is an optimisation
>>> that is only interesting if there is a danger from the forcewake being
>>> dropped mid-sequence (due to preemption whatever).
>>
>> We're also accessing the punit in valleyview_set_rps() and I've seen several
>> patches (in the android x86 kernel) suggesting that we need to take a wakelock
>> while doing this.
>
> It is quite likely that we do have to guarantee to keep the punit awake
> during long sequences. That would be an acceptable rationale (but not in
> the caller!).

So what would be a good approach, take FORCEWAKE_ALL in valleyview_set_rps()
itself (and drop the existing code from vlv_set_rps_idle()) ?

Regards,

Hans
