//
//  Macros.h
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/17/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#ifndef TwentyMinuteGenealogist_Macros_h
#define TwentyMinuteGenealogist_Macros_h

// Nice view stuff..
#define SetFrameX(_a_, _x_) { CGRect tempframe = _a_.frame; tempframe.origin.x = _x_; _a_.frame = tempframe; }
#define SetFrameY(_a_, _y_) { CGRect tempframe = _a_.frame; tempframe.origin.y = _y_; _a_.frame = tempframe; }
#define SetFrameWidth(_a_, _w_) { CGRect tempframe = _a_.frame; tempframe.size.width = _w_; _a_.frame = tempframe; }
#define SetFrameHeight(_a_, _h_) { CGRect tempframe = _a_.frame; tempframe.size.height = _h_; _a_.frame = tempframe; }

#define SetFrameOrigin(_a_, __origin__) { CGRect tempframe = _a_.frame; tempframe.origin.x = __origin__.x; tempframe.origin.y = __origin__.y; _a_.frame = tempframe; }
#define SetFrameXAndY(_a_, _x_, _y_) { CGRect tempframe = _a_.frame; tempframe.origin.x = _x_; tempframe.origin.y = _y_; _a_.frame = tempframe; }
#define SetFrameSize(__view__, __size__) { CGRect tempFrame = __view__.frame; tempFrame.size = __size__; __view__.frame = tempFrame; }

#endif
