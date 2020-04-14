package validation

import (
	"context"
	"github.com/containerd/containerd/log"
	"github.com/go-playground/validator/v10"
	"github.com/sirupsen/logrus"
)

// lifted from https://github.com/go-playground/validator/blob/master/_examples/struct-level/main.go#L68
func ValidateStruct(ctx context.Context, validate *validator.Validate, p interface{}) error {
	logger := log.G(ctx)
	if err := validate.Struct(p); err != nil {
		// this check is only needed when your code could produce
		// an invalid value for validation such as interface with nil
		if err, ok := err.(*validator.InvalidValidationError); ok {
			logger.WithError(err).Error("Invalid value validation error")
			return err
		}

		for _, err := range err.(validator.ValidationErrors) {
			logger.WithFields(logrus.Fields{
				"namespace":       err.Namespace(),
				"field":           err.Field(),
				"structNamespace": err.StructNamespace(),
				"structField":     err.StructField(),
				"tag":             err.Tag(),
				"actualTag":       err.ActualTag(),
				"kind":            err.Kind(),
				"type":            err.Type(),
				"value":           err.Value(),
				"param":           err.Param(),
				logrus.ErrorKey:   err,
			}).Error("Validation error details")
		}
		return err
	}
	return nil
}
