# FlyBtn


使用方式:

```
let flyBtn = FlyButton(type: .custom)
flyBtn.frame = CGRect(x: 45, y: 200, width: 45, height: 45)
flyBtn.setImage(UIImage(named: "fly_icon"), for: .normal)
flyBtn.addFlyAttributeEvent(clickEvent: {

})
view.addSubview(flyBtn)
```
